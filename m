Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752007AbWG1Pgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbWG1Pgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWG1Pgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:36:46 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:19100
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1752007AbWG1Pgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:36:45 -0400
Message-ID: <44CA2F07.4020908@microgate.com>
Date: Fri, 28 Jul 2006 10:36:39 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: tty buffering limit
References: <200607221209_MC3-1-C5CA-50EB@compuserve.com>	 <44C25548.5070307@microgate.com> <20060725184158.GH9021@kroah.com>	 <44C66D1C.7010903@microgate.com>  <20060726071652.GA6204@kroah.com>	 <1153941029.6903.5.camel@amdx2.microgate.com> <1154094816.13509.132.camel@localhost.localdomain>
In-Reply-To: <1154094816.13509.132.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Certain people seem to have assumed tty->throttled was 'advisory'. In
> the absence of tty->author->throttle(), it seems we should keep a simple
> limit of our own to avoid problems when this occurs. 

Looks reasonable as a general failsafe. There
may be other pathological cases it protects against.

I'll start banging on it.

-- 
Paul Fulghum
Microgate Systems, Ltd.
