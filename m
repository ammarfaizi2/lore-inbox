Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274995AbRIYNRU>; Tue, 25 Sep 2001 09:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274996AbRIYNRK>; Tue, 25 Sep 2001 09:17:10 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:58382 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S274995AbRIYNQ6> convert rfc822-to-8bit; Tue, 25 Sep 2001 09:16:58 -0400
Date: Tue, 25 Sep 2001 15:17:21 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010925151721.C9890@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010924173210.A7630@emma1.emma.line.org> <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there> <3BB07EA2.4010804@juridicas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <3BB07EA2.4010804@juridicas.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please only quote the relevant parts, particularly, would you
erase deeper nesting of quotes in your replies? That'd help a lot of
people transfer less data they can still easily get from their own
mailer at a keypress. Thanks a lot.

On Tue, 25 Sep 2001, Jorge Nerín wrote:

> Who says test.zero is a linear file and it's not scattered around the 
> whole disk and the fs layer is filling holes...? If it's the case the 
> write cache is a BIG win, just think that the fs writes a chunk at the 
> beggining of the disk, then another chunk at the end, then another near 
> the beginning, then...  you get the picture, in this case the disk 
> reorders the seeks to best fit.
> 
> If you want to try a REAL linear write do a dd if=/dev/zero of=/dev/hde7 
> or whatever unused partition you have.

I did, and it showed almost the same behaviour, twice as fast with write
cache turned on.

Scattering the writes would (usually) only happen on a nearly filled
disk.
