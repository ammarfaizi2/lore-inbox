Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVAWU7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVAWU7J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 15:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVAWU7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 15:59:09 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:33722 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261352AbVAWU7F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 15:59:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Gz/SaAAoF2J4nUqVV1gdh+m5F/r/adoF002wSrLnmkDSfBKKSRUf31UnT/8Ec840UWBm//MuU9wu5Pi5oUo1p/ATddHzB2Y4ZbJv6ZwBdAVgD1jGDZ62QO2iqrngO7BSyph/iwJrP917rFDBdJPGL1k9aeMQgHlC9XWT5/Du/8Y=
Message-ID: <5a4c581d050123125967a65cd7@mail.gmail.com>
Date: Sun, 23 Jan 2005 21:59:04 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Subject: Re: DVD burning still have problems
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2005 21:26:55 +0100, Volker Armin Hemmann
<volker.armin.hemmann@tu-clausthal.de> wrote:
> Hi,
> 
> have you checked, that cdrecord is not suid root, and growisofs/dvd+rw-tools
> is?
> 
> I had some probs, solved with a simple chmod +s growisofs :)

Lucky you. Burning as root here, cdrecord not suid. Tried also
 burning with a +s growisofs, but...

 794034176/4572807168 (17.4%) @2.4x, remaining 18:47
 805339136/4572807168 (17.6%) @2.4x, remaining 18:42
:-[ WRITE@LBA=60eb0h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output error
builtin_dd: 396976*2KB out @ average 2.4x1385KBps
:-( write failed: Input/output error
/dev/hdc: flushing cache
/dev/hdc: stopping de-icing
/dev/hdc: writing lead-out

> Glück Auf
> Volker

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")
