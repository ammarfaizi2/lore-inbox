Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264987AbSJOWvX>; Tue, 15 Oct 2002 18:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265128AbSJOWvL>; Tue, 15 Oct 2002 18:51:11 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:9233 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S264987AbSJOWYg>;
	Tue, 15 Oct 2002 18:24:36 -0400
Date: Tue, 15 Oct 2002 22:28:02 +0000
From: Eduardo =?iso-8859-1?Q?P=E9rez?= <100018135@alumnos.uc3m.es>
To: Marius Gedminas <mgedmin@centras.lt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fork() wait semantics
Message-ID: <a074067cb9f2b74a80a9f9f03f0abcaa@alumnos.uc3m.es>
References: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz> <34f5602687bbb910752d5becee9c9aa1@alumnos.uc3m.es> <20021015180743.GD7511@gintaras>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021015180743.GD7511@gintaras>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-15 20:07:43 +0200, Marius Gedminas wrote:
> On Tue, Oct 15, 2002 at 04:58:44PM +0000, Eduardo Pérez wrote:
> > As an example consider bash. In case of fork() error the program
> > isn't even run thus causing a fatal error. If fork() waited for
> > resources to be available there wouldn't be any problem.
> 
> No, thank you.  This happened to me more than once (runaway fetchmail
> plugins).  An error message about a failing fork() indicates
> immediately that I have too many processes, and I can kill them
> (thankfully kill is a bash builtin).  If bash just waited silently I
> wouldn't know what to think.

But you are talking about buggy software.
If you software has bugs don't expect it to work properly.

These fork() semantics are for non-buggy software.
