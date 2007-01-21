Return-Path: <linux-kernel-owner+w=401wt.eu-S1751315AbXAUKFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbXAUKFF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 05:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbXAUKFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 05:05:05 -0500
Received: from mx0.towertech.it ([213.215.222.73]:35246 "HELO mx0.towertech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751315AbXAUKFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 05:05:04 -0500
Date: Sun, 21 Jan 2007 11:04:59 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, akpm@osdl.org
Subject: Re: [patch] remove __devinit markings from rtc_sysfs_add_device()
Message-ID: <20070121110459.458e397b@inspiron>
In-Reply-To: <200701201111.03507.vapier@gentoo.org>
References: <200701201111.03507.vapier@gentoo.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2007 11:11:02 -0500
Mike Frysinger <vapier@gentoo.org> wrote:

> the sysfs interface from the rtc framework seems to incorrectly label the add 
> function with __devinit ... the proc and dev interfaces do not have this 
> label on their add functions
> 
> ive been trying to develop a rtc module and it kept crashing ... after 
> debugging it, i'm pretty sure ive traced it back to the devinit markings ... 
> dropping this lets my module load nicely :)

 thanks for spotting it!

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

