Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319045AbSHFKXe>; Tue, 6 Aug 2002 06:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319046AbSHFKXe>; Tue, 6 Aug 2002 06:23:34 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:36862 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S319045AbSHFKXc>;
	Tue, 6 Aug 2002 06:23:32 -0400
Date: Tue, 6 Aug 2002 12:27:07 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: martin@dalecki.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.30 IDE 112
Message-ID: <20020806102707.GA29785@win.tue.nl>
References: <3D4F8DE2.8020904@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4F8DE2.8020904@evision.ag>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 10:50:42AM +0200, Marcin Dalecki wrote:
> - Just removaing dead obscure xlate_1024 code.

Hmm. You have a somewhat literal idea of "dead": code that is not
called today, regardless of whether it was called yesterday and
will be needed tomorrow.

Just plain removing everything keeps the source clean but has
the unpleasant side effect that Linux no longer works on certain
machines.

Command line options must be added to ask for what this
xlate_1024 code did earlier. So, some fragments of what you remove
in this patch will have to come back in some form.

Andries
