Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTIHGWJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 02:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbTIHGWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 02:22:08 -0400
Received: from f9.mail.ru ([194.67.57.39]:10756 "EHLO f9.mail.ru")
	by vger.kernel.org with ESMTP id S262052AbTIHGWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 02:22:06 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Nicolas Mailhot=?koi8-r?Q?=22=20?= 
	<Nicolas.Mailhot@laPoste.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sensors and linux 2.6.0-test4-bk8 question
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 08 Sep 2003 10:20:07 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19wFNf-000Pu7-00.arvidjaar-mail-ru@f9.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know libsensors is not yet 2.6 aware, but I thought sensed values
> where available in sysfs if one wanted to manually read them. Since I
> have via hardware:


You could try patches in <http://marc.theaimsgroup.com/?l=linux-kernel&m=106234771107439&w=2>

They slightly modify kernel sensors names and add patch to libsensors
to deal with it. You have to build libsensors using kernel 2.4 sources
still but after that it should work for both 2.4 and 2.6.

-andrey
