Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVBNQsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVBNQsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 11:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVBNQsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 11:48:35 -0500
Received: from smtpout3.uol.com.br ([200.221.4.194]:62670 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261482AbVBNQsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 11:48:14 -0500
Date: Mon, 14 Feb 2005 14:48:10 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: How to get the maximum output from dmesg command
Message-ID: <20050214164810.GA12738@ime.usp.br>
Mail-Followup-To: "Srinivas G." <srinivasg@esntechnologies.co.in>,
	linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
References: <4EE0CBA31942E547B99B3D4BFAB3481134E2AE@mail.esn.co.in> <20050214161950.GA10253@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050214161950.GA10253@DervishD>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas G. <srinivasg@esntechnologies.co.in> wrote:
> How to get maximum output from dmesg command? 
> I am unable to see all my debug messages after loading my driver. 
> I think there is a restriction in displaying the dmesg output. 

There is indeed.

> I saw in printk.c file under source directory. There I found LOG_BUF_LEN
> is 16384.

Sorry if this is obvious, but have you considered using the -s option of
dmesg?


Hope I understood it correctly, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
