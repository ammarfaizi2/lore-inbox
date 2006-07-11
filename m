Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWGKUoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWGKUoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWGKUoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:44:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:62943 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751297AbWGKUoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:44:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dHkB4MIvQqKJ1dPf0guUn++mujZr2j+vVknPyGsagqlQjQBJ7DwEfqI3whvQ+XlW+p+NVSrF4Rhzl+yxhN+m06VAnEDGbi6iLS3b5KZ4Nu8KSaWSZXzZ3E6NiTNMg2y3ESsuLbWhb5SWpgL7CCRw11ZcHrXZSEWuZy09LywVs44=
Message-ID: <a762e240607111344n73434f33n8297e92c0cc0b30@mail.gmail.com>
Date: Tue, 11 Jul 2006 13:44:01 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Shailabh Nagar" <nagar@watson.ibm.com>
Subject: Re: 2.6.18-rc1-mm1 panic on boot x86_64 NMI watchdog detected LOCKUP
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <44B408D6.1090505@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a762e240607111112v1bd28135hf99fdf0cc08a6d52@mail.gmail.com>
	 <20060711132102.acb46e5c.akpm@osdl.org>
	 <44B408D6.1090505@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Shailabh Nagar <nagar@watson.ibm.com> wrote:
> Andrew Morton wrote:
> > Thanks.  Shailabh sent the below patch through yesterday.  It looks awfully
> > similar.
>
>
> Yes, this lockup on boot is caused by not initializing the per-cpu
> semaphores early enough. The patch below should fix it.
>

Thanks.  I applied the patch and the system booted :)

Keith
