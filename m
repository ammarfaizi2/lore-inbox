Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137111AbREKLTd>; Fri, 11 May 2001 07:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137112AbREKLT0>; Fri, 11 May 2001 07:19:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45975 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S137111AbREKLTO>;
	Fri, 11 May 2001 07:19:14 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15099.51885.790847.794749@pizda.ninka.net>
Date: Fri, 11 May 2001 04:19:09 -0700 (PDT)
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Cc: Andi Kleen <ak@suse.de>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: Source code compatibility in Stable series????
In-Reply-To: <200105111039.MAA18522@cave.bitwizard.nl>
In-Reply-To: <20010511123257.A6023@gruyere.muc.suse.de>
	<200105111039.MAA18522@cave.bitwizard.nl>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rogier Wolff writes:
 > But it's always been said that source code compatiblity would be
 > maintained.

"when possible", we've made no such total souce level
compat. guarentee.  And more such changes are coming, for example the
quota bugs can't be fixed without breaking source level compat. for
the filesystems.

You may think and argue otherwise, but our ability to break source
level compatibility is one of our strengths (see solaris rsh root
owned socket bug of yesteryear for one example as to why).

Later,
David S. Miller
davem@redhat.com

