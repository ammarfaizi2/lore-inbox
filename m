Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280819AbRKYLPn>; Sun, 25 Nov 2001 06:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280820AbRKYLPc>; Sun, 25 Nov 2001 06:15:32 -0500
Received: from marine.sonic.net ([208.201.224.37]:41788 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S280819AbRKYLPU>;
	Sun, 25 Nov 2001 06:15:20 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sun, 25 Nov 2001 03:14:53 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Zimmermann <zim@vegaa.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: Moving ext3 journal file
Message-ID: <20011125031452.B27959@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org, Michael Zimmermann <zim@vegaa.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <E167Fuw-00001K-00@DervishD> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com> <20011123174120.Q1308@lynx.no> <9tmr83$jo2$1@cesium.transmeta.com> <20011123212557.U1308@lynx.no> <3BFF2AAE.7000000@zytor.com> <3BFF8692.7060900@vegaa.de> <20011125023314.B30336@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011125023314.B30336@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 02:33:14AM -0800, Mike Fedyk wrote:
> The newest e2fsck (1.25) will hide the file for you, just like it would be
> if the conversion was done on an unmounted FS.


Actually, to re-iterate a recent point:  No, it won't.

The next version of e2fsck should.  But 1.25 does NOT do that.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
