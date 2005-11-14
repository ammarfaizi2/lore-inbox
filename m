Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVKNRiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVKNRiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVKNRiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:38:19 -0500
Received: from rtr.ca ([64.26.128.89]:55950 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751211AbVKNRiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:38:17 -0500
Message-ID: <4378CB83.1050401@rtr.ca>
Date: Mon, 14 Nov 2005 12:38:11 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: Badari Pulavarty <pbadari@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.xx:  dirty pages never being sync'd to disk?
References: <4378ADB2.7040905@rtr.ca>	 <1131982550.2821.41.camel@laptopd505.fenrus.org>  <4378B1FB.1060201@rtr.ca> <1131987398.24066.7.camel@localhost.localdomain> <4378C626.4030107@rtr.ca>
In-Reply-To: <4378C626.4030107@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh... there's the magic line I needed:

	#define _GNU_SOURCE
