Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264794AbSJOSB6>; Tue, 15 Oct 2002 14:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264798AbSJOSB5>; Tue, 15 Oct 2002 14:01:57 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:19196 "EHLO
	mg.homelinux.net") by vger.kernel.org with ESMTP id <S264794AbSJOSB5>;
	Tue, 15 Oct 2002 14:01:57 -0400
Date: Tue, 15 Oct 2002 20:07:43 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: fork() wait semantics
Message-ID: <20021015180743.GD7511@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz> <34f5602687bbb910752d5becee9c9aa1@alumnos.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34f5602687bbb910752d5becee9c9aa1@alumnos.uc3m.es>
User-Agent: Mutt/1.4i
X-Message-Flag: If you do not see this message correctly, stop using Outlook.
X-GPG-Fingerprint: 8121 AD32 F00A 8094 748A  6CD0 9157 445D E7A6 D78F
X-GPG-Key: http://ice.dammit.lt/~mgedmin/mg-pgp-key.txt
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 04:58:44PM +0000, Eduardo Pérez wrote:
> As an example consider bash. In case of fork() error the program
> isn't even run thus causing a fatal error. If fork() waited for
> resources to be available there wouldn't be any problem.

No, thank you.  This happened to me more than once (runaway fetchmail
plugins).  An error message about a failing fork() indicates
immediatelly that I have too many processes, and I can kill them
(thankfully kill is a bash builtin).  If bash just waited silently I
wouldn't know what to think.

Marius Gedminas
-- 
This sentence contradicts itself -- no actually it doesn't.
                -- Douglas Hofstadter
