Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUFOTDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUFOTDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFOTCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:02:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8619 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265874AbUFOTCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:02:25 -0400
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Cesar Eduardo Barros <cesarb@nitnet.com.br>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
References: <20040612011129.GD1967@flower.home.cesarb.net>
	<orpt81sv1g.fsf@free.redhat.lsd.ic.unicamp.br>
	<20040614220917.GA18941@citd.de>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 15 Jun 2004 16:02:12 -0300
In-Reply-To: <20040614220917.GA18941@citd.de>
Message-ID: <orbrjkabm3.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 14, 2004, Matthias Schniedermeyer <ms@citd.de> wrote:

> On Mon, Jun 14, 2004 at 06:12:59PM -0300, Alexandre Oliva wrote:

>> I've heard more than once about the atime bit being used to as
>> proof that a user had actually seen the contents of a file although
>> s/he claimed s/he hadn't.  If it was root-only,

> man mount
> /noatime
-> You can disable updating the atime for the whole filesystem.

As a sysadmin that intends to use atime as proof, you don't do that.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
