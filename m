Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268822AbTBZQya>; Wed, 26 Feb 2003 11:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268828AbTBZQy3>; Wed, 26 Feb 2003 11:54:29 -0500
Received: from are.twiddle.net ([64.81.246.98]:36514 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S268822AbTBZQy3>;
	Wed, 26 Feb 2003 11:54:29 -0500
Date: Wed, 26 Feb 2003 09:04:15 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eliminate warnings in generated module files
Message-ID: <20030226090415.A16940@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302251930280.13501-100000@chaos.physics.uiowa.edu> <20030226041359.C54792C04C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030226041359.C54792C04C@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Feb 26, 2003 at 03:13:09PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 03:13:09PM +1100, Rusty Russell wrote:
> I'd love to frop the #ifdef and just mark them __optional: before that
> would just mean bloat, but when gcc 3.3 rolls in, they should vanish
> nicely.

Um, no, as mentioned in the comment, at present only unused
static functions will get removed.  Data isn't touched, yet.


r~
