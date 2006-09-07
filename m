Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWIGR0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWIGR0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 13:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWIGR0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 13:26:25 -0400
Received: from qb-out-0506.google.com ([72.14.204.233]:3051 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422654AbWIGR0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 13:26:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DfcwTBJUVoc+rObEJLK44Ykn+OKlrl383d6dHo8uNlkM1yiplKlrFiPW46pDaoQl8DgS3O7Bs0HwgggG6JJ4omMVAgt4ovYUC5gzF6WIoUPvqFXh8xRZgoUQpe4c439uKhi6O9g7LyJ8j4KT01pwkeNuDh7+o8Yd3QeXDaF1jcQ=
Message-ID: <45005657.8000509@gmail.com>
Date: Thu, 07 Sep 2006 11:26:47 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
CC: Samuel Tardieu <sam@rfc1149.net>, linux-kernel@vger.kernel.org,
       wim@iguana.be, Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <44FEAD7E.6010201@draigBrady.com>
In-Reply-To: <44FEAD7E.6010201@draigBrady.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pádraig Brady wrote:
> Is W83697HG a good name?
>   


could you add a suffix, say _watchdog ?

the name youve got is confusingly close to the convention used in 
drivers/hwmon

 ls hwmon/w*.c
hwmon/w83627ehf.c  hwmon/w83627hf.c  hwmon/w83781d.c  hwmon/w83791d.c  
hwmon/w83792d.c  hwmon/w83l785ts.c

