Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136242AbREAW11>; Tue, 1 May 2001 18:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136740AbREAW1Q>; Tue, 1 May 2001 18:27:16 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47591 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136242AbREAW1F>;
	Tue, 1 May 2001 18:27:05 -0400
Date: Tue, 1 May 2001 15:26:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...]
Message-ID: <20010501152611.A12378@opus.bloom.county>
In-Reply-To: <20010427193501.A9805@thyrsus.com> <15084.12152.956561.490805@gargle.gargle.HOWL> <20010429183526.B32748@thyrsus.com> <15085.37569.205459.898540@gargle.gargle.HOWL> <20010430133932.B28849@thyrsus.com> <20010430141623.A15821@cadcamlab.org> <20010430152536.A29699@thyrsus.com> <3AEE80A3.EB0ACEB1@dplanet.ch> <20010501123112.A7699@thyrsus.com> <20010501173512.A2815@zalem.puupuu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010501173512.A2815@zalem.puupuu.org>; from galibert@pobox.com on Tue, May 01, 2001 at 05:35:12PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 05:35:12PM -0400, Olivier Galibert wrote:
> On Tue, May 01, 2001 at 12:31:12PM -0400, Eric S. Raymond wrote:
> > You are proposing an interface that will handle easy cases but blow
> > up in the user's face in any hard one.  That's poor design, frustrating
> > the user exactly when he/she most needs help.
> 
> Yeah, but what is the current method, vi?

If you edit a .config (current or CML2'ed) and fix a problem, it works.
What was the question again?  (And, if you edit an old .config, %s/^# CONFIG/CONFIG and %s/ is not set/=n, oldconfig works like you would expect, and can help
point out places where CML2 is slightly off).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
