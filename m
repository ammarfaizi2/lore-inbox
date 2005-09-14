Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVINFHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVINFHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 01:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVINFHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 01:07:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:16046 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S965009AbVINFHT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 01:07:19 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH] SELinux - convert to kzalloc
Date: Wed, 14 Sep 2005 08:06:44 +0300
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@epoch.ncsc.mil>
References: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode>
In-Reply-To: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509140806.44304.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 September 2005 18:18, James Morris wrote:
> -       *names = (char**)kmalloc(sizeof(char*) * *len, GFP_ATOMIC);
> +       *names = (char**)kzalloc(sizeof(char*) * *len, GFP_ATOMIC);

Extra cast
--
vda
