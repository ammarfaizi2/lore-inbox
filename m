Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752011AbWG1PT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbWG1PT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWG1PT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:19:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:55792 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752011AbWG1PT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:19:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LyYpWJs4DxmV96qnSp53l/qNOAQliKeZgQptKLvPdsSUjyfTK3MhQbQCb1AbYwXYMEwEeAGPWBU/li/9WAhLqOEE92uo1t8jQSpxepTZp/izMFayYwenIDaeYXEXrmL8X5VYjxavN6IBRIOoRw0e8/ITRnOgS/rcpM7Swce9lfA=
Message-ID: <41840b750607280819t71f55ea7off89aa917421cc33@mail.gmail.com>
Date: Fri, 28 Jul 2006 18:19:46 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Generic battery interface
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       "Pavel Machek" <pavel@suse.cz>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 4) sysfs - all capabilities, IDs, etc for input devices exported there as well.

Forgive my ignorance, but how do I conncet a sysfs directory with a /dev device?
So far the only way I found is to compare /sys/whatever/dev with the
major+minor of the dev file, which requires brute-force enumeration on
at least one side.

  Shem
