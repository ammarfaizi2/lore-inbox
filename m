Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVDADnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVDADnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 22:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVDADnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 22:43:05 -0500
Received: from smtp818.mail.sc5.yahoo.com ([66.163.170.4]:44711 "HELO
	smtp818.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262578AbVDADnD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 22:43:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Corey Minyard <cminyard@mvista.com>
Subject: Re: sysfs for IPMI, for new mm kernels
Date: Thu, 31 Mar 2005 22:43:01 -0500
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
References: <424CB9DA.1040707@mvista.com>
In-Reply-To: <424CB9DA.1040707@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503312243.02139.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 March 2005 22:02, Corey Minyard wrote:
> +       snprintf(name, sizeof(name), "ipmi%d", if_num);
> +       class_device_create(ipmi_class, dev, NULL, name);
> 

class_device_create(ipmi_class, dev, NULL, "ipmi%d", if_num) ?

-- 
Dmitry
