Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267468AbUHPGsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267468AbUHPGsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267469AbUHPGsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:48:37 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:46496
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267468AbUHPGsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:48:19 -0400
Message-ID: <412058AF.3090102@bio.ifi.lmu.de>
Date: Mon, 16 Aug 2004 08:48:15 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <Pine.LNX.4.44.0408140123350.5637-100000@hubble.stokkie.net>
In-Reply-To: <Pine.LNX.4.44.0408140123350.5637-100000@hubble.stokkie.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert M. Stockmann wrote:

> Maybe you didn't fully understand my problem. What i did was the 
> following. I downloaded cdrtools-2.01a27.tar.bz2 from 
> 
> ftp://ftp.berlios.de/pub/cdrecord/alpha/
> 
> and only applied this patch cdrtools-2.01a27-ossdvd.patch.bz2 from
> 
> ftp://ftp.crashrecovery.org/pub/linux/cdrtools/

And the question is: why??? SuSE comes with a cdrtools version that runs
fine. No need to download anything from an external source. Just installing
the cdrtools package from SuSE and calling "cdrecord dev=/dev/hdc ..."
works without any problems here.

You are complaining here that using some external package as replacement
for the SuSE version and additionally forcing a setting other than the
default does not work, even after a SuSE developer told you not to do
that because there are known problems with the setting you are forcing.

So what are you asking for? I guess I can find a bunch of programs that
I download from anywhere and that are not working with some distributions.
The idea of a distribution is that the packagers take care that the packages
they deliver work together. Replacing some piece with your own version
and then complaining that it does not work doesn't make any sense.
This is like replacing the "eject" on SuSE 9.1 which has been patched
to work with subfs and then complaining that your own "eject" does not
work with subfs on SuSE 9.1.

Frank


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

