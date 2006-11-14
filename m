Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966433AbWKNW4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966433AbWKNW4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966434AbWKNW4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:56:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:8854 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966433AbWKNW4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:56:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Qz2jGYr+Nkt7RWAmK0yy3ZbeQlrpKY0n+v40/XdS4AbbeLg3CWzYsyxZYoJdS+tjxHkXMF6dm+LF7BRkbjdcJPM4mtIO8z1AldRPkkNaVRBL1gIj+95IerXXxnWee5XVGPJpTiG8fQ8nnxt7ZD+1aznOd9LG7w90LInxKiqpsmw=
Message-ID: <40f323d00611141456i7d538593vaf7e962121b6009d@mail.gmail.com>
Date: Tue, 14 Nov 2006 23:56:18 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.19-rc5-mm2 -- 3d slow with dynticks
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/06, Andrew Morton <akpm@osdl.org> wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/
>

CONFIG_NO_HZ=y still gives me slow 3d games on this one whereas
2.6.19-rc5-mm1 +
http://tglx.de/private/tglx/2.6.19-rc5-mm1-dyntick.diff was fine.

Maybe some patches where not merged ?

regards,

Benoit
