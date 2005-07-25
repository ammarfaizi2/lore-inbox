Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVGYEKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVGYEKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 00:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVGYEK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 00:10:29 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:35952 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261583AbVGYEKY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 00:10:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dJnyUrDwT1G4YnNB4ARa4KFN70VCYanhAVBIdo9rdXfwmrBYVDRGvCV0Z0im123duqf2yLdqxk6b6JMS7T5BLo5LpFog4TNdludv8dhCcS3So6Xox/POY6r83caZ/BdeFrBJqFP75ak2Pa4svE8/knRT/s0Yl8auHIYR9RHN8Ko=
Message-ID: <f8994115050724211071a3dbe1@mail.gmail.com>
Date: Mon, 25 Jul 2005 00:10:15 -0400
From: Florin Malita <fmalita@gmail.com>
Reply-To: Florin Malita <fmalita@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 speed
In-Reply-To: <1122248869.10835.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
	 <1122248869.10835.25.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> time() isn't a hot
> path in the real world.

That's what you would expect but I've straced stuff calling
gettimeofday() in huge bursts every other second. Obviously braindead
stuff but so is "the real world" most of the time() ... :)
