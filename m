Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754344AbWKIHzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbWKIHzJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754360AbWKIHzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:55:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:62601 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754344AbWKIHzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:55:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Kh4zSvZ0P+b+Q7+rUa3F7VAzG5hSCH3Bo7ROlcx4CNeym+goWuiIB/jzC1RVKPHTktSZ8NZA1CUnL454ldg0oJaLgQ+0VElck8N3o9z8dctOmlKjZzwaZEqwO1jRAdFC4g5USj+V/FgC0vFlmsUrtKD8Y3JjRSe7OPegNCWJz5w=
Message-ID: <86802c440611082355q67c69da2v316062bbe0170a9@mail.gmail.com>
Date: Wed, 8 Nov 2006 23:55:03 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: 2.6.19-rc5 x86_64 irq 22: nobody cared
Cc: "Olivier Nicolas" <olivn@trollprod.org>,
       "Stephen Hemminger" <shemminger@osdl.org>,
       "Takashi Iwai" <tiwai@suse.de>, "Jaroslav Kysela" <perex@suse.cz>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <20061109064956.GG4729@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4551D12D.4010304@trollprod.org> <20061109064956.GG4729@stusta.de>
X-Google-Sender-Auth: 7b665d69c99347a2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

olivier,

lspci -vvxxx please.

it seems usb and audio share the interrtupts by ioapic.

YH
