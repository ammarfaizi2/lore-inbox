Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285361AbRLSQQL>; Wed, 19 Dec 2001 11:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285358AbRLSQQB>; Wed, 19 Dec 2001 11:16:01 -0500
Received: from dnph.phys.msu.su ([193.232.121.81]:10258 "HELO dnph.phys.msu.su")
	by vger.kernel.org with SMTP id <S285357AbRLSQPo>;
	Wed, 19 Dec 2001 11:15:44 -0500
Content-Type: text/plain;
  charset="koi8-r"
From: Oleg Artamonov <oleg@dnph.phys.msu.su>
Organization: Moscow State University, Department of Nuclear Physics
To: Thomas Deselaers <thomas@deselaers.de>, linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Date: Wed, 19 Dec 2001 19:15:34 +0300
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de> <20011219155538.BF29F3B92@dnph.phys.msu.su> <20011219160529.GA3930@leukertje.hitnet.rwth-aachen.de>
In-Reply-To: <20011219160529.GA3930@leukertje.hitnet.rwth-aachen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011219161535.43EE17925@dnph.phys.msu.su>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Deselaers написал:

> Here are the results, and maybe I should have told, that I am using 2.4.16
> without any further patches applied.

  Yes, i'm using 2.4.8 form Mandrake distribution.

> leukertje:/home/thomasd# hdparm /dev/hdc
>
> /dev/hdc:
>  multcount    = 16 (on)
>  I/O support  =  0 (default 16-bit)
		^^^
  'hdparm -c1 /dev/hda' to enable 32-bit access - it will be much faster.
