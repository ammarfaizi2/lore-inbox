Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbULGMeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbULGMeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 07:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbULGMeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 07:34:11 -0500
Received: from mx01.cybersurf.com ([209.197.145.104]:26083 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S261798AbULGMeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 07:34:08 -0500
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Karsten Desler <kdesler@soohrt.org>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041207102132.GA28588@quickstop.soohrt.org>
References: <20041206224107.GA8529@soohrt.org>
	 <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net>
	 <20041207002012.GB30674@quickstop.soohrt.org>
	 <1102387595.1088.48.camel@jzny.localdomain>
	 <20041207025456.GA525@soohrt.org>
	 <1102389533.1089.51.camel@jzny.localdomain>
	 <20041207032438.GA7767@soohrt.org>
	 <1102390241.1093.59.camel@jzny.localdomain>
	 <20041207040235.GA10501@soohrt.org>
	 <20041207102132.GA28588@quickstop.soohrt.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102422845.1089.105.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Dec 2004 07:34:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 05:21, Karsten Desler wrote:

> But looking and the int/s number, I'm not so sure anymore. Is there any
> other way to find out?
> 

> # sar -I 169 5 5
> 11:20:05         INTR    intr/s
> 11:20:10          169  10401.40

That doesnt seem to be too high. 
You have a dual opteron 244. You are supposed to be kicking ass with
that machine - not 200Kpps+ you are getting with all that CPU overload.
Something is wrong with your setup. Unfortunately i cant afford such a
machine so i cant see it right off the bat. I know Robert has at least
one similar machine; maybe he could help. Robert?

cheers,
jamal 

