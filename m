Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285269AbRLSNDs>; Wed, 19 Dec 2001 08:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285262AbRLSNDi>; Wed, 19 Dec 2001 08:03:38 -0500
Received: from t2.redhat.com ([199.183.24.243]:1781 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S284979AbRLSNDe>; Wed, 19 Dec 2001 08:03:34 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <5.1.0.14.2.20011219144636.03498a10@mail.teraflops.com> 
In-Reply-To: <5.1.0.14.2.20011219144636.03498a10@mail.teraflops.com> 
To: Marko =?ISO-8859-1?Q?Kentt=E4l=E4?= <marko.kenttala@teraflops.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel memory usage optimisations? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Dec 2001 13:03:32 +0000
Message-ID: <7603.1008767012@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


marko.kenttala@teraflops.com said:
>  I understand that best area for saving memory usage is the C-library
> but  are there any other kernel areas? I'm thinking of dropping
> swapfile support  and maybe some other subsystems that are not needed
> in embedded device. 

You could potentially remove block device support altogether.

--
dwmw2


