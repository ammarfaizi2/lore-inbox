Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWHJAIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWHJAIO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWHJAIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:08:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:24083 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932249AbWHJAIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:08:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=AY1pDjWXaflwPZGIEsc9HBFr0mTicGY5FZfg/0qmjwf89ej3iRDVnmujPIBMYJ7581ojDSrttJ+s4LVYoaAXDB0tspZEtDHjRl+NZrem2u7iHNU/QD53+250iBDkr20KzlJlPNi12YL5ZBwBttNE850sBkV/E5YvKb/kMR3/91g=
Message-ID: <e9e943910608091708p4914930ct1ee031a1201bfd2f@mail.gmail.com>
Date: Thu, 10 Aug 2006 01:08:12 +0100
From: "Duane Griffin" <duaneg@dghda.com>
To: "Molle Bestefich" <molle.bestefich@gmail.com>
Subject: Re: ext3 corruption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f0608091609q6b3c6c4ev2d287060fa209@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com>
	 <62b0912f0608091347u8b86d40q3679991e9e16526f@mail.gmail.com>
	 <e9e943910608091527t3b88da7eo837f6adc1e1e6f98@mail.gmail.com>
	 <62b0912f0608091609q6b3c6c4ev2d287060fa209@mail.gmail.com>
X-Google-Sender-Auth: 1c27f7724dc13543
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/06, Molle Bestefich <molle.bestefich@gmail.com> wrote:
> If it doesn't take into account own changes, then the -n command is
> unable to produce even a slightly accurate resemblence of what would
> happen if I did a real run.

It takes into account some of them (such as reading data from the
backup superblock if it detects corruption). Others will be irrelevent
for further operations. Many reports will be accurate, especially
fatal ones. I consider that useful, YMMV.

Cheers,
Duane.

-- 
"I never could learn to drink that blood and call it wine" - Bob Dylan
