Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbTF1Vlb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 17:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbTF1Vlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 17:41:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1419
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265429AbTF1Vla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 17:41:30 -0400
Subject: Re: Patch 2.4.21 use propper type for pid -II
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Walter Harms <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E19WMeK-000CqW-00@grossglockner.Informatik.Uni-Oldenburg.DE>
References: <E19WMeK-000CqW-00@grossglockner.Informatik.Uni-Oldenburg.DE>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056837174.6753.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 22:52:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-28 at 21:50, Walter Harms wrote:
> Hi liste,
> this is a small patch to fix functions that do not use the 
> correct type for pid. daniele bellucci and i have worked this 
> out. 

For the syscalls the pid is passed as an integer so they are right as is

