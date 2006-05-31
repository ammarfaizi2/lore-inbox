Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWEaQeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWEaQeW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWEaQeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:34:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:55708 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750984AbWEaQeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:34:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=LbRMI7e1ezyLucrKkkNT2b4lni0vcr8OMNDD9AzIVgHZDTHmn2C/uMEXMmSJBcWF3zgjHVejuqG7vYvfPXCCZU4mGKEPcW064vSn5FiK8XII0FVwJ9+/iXsNGHTG7Dwwa8zljLM7yJ86lZqAVpaoIT4F7T7VB/jQtctolM2DL7k=
Date: Wed, 31 May 2006 20:38:23 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
Subject: Re: 2.6.17-rc5-mm1 - output of lock validator
Message-Id: <20060531203823.bc77da92.pauldrynoff@gmail.com>
In-Reply-To: <1149085739.3114.34.camel@laptopd505.fenrus.org>
References: <20060530195417.e870b305.pauldrynoff@gmail.com>
	<20060530132540.a2c98244.akpm@osdl.org>
	<20060531181926.51c4f4c5.pauldrynoff@gmail.com>
	<1149085739.3114.34.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 16:28:59 +0200
Arjan van de Ven <arjan@linux.intel.com> wrote:

> On Wed, 2006-05-31 at 18:19 +0400, Paul Drynoff wrote:

> Make the ne2000 drivers use irqsave, they already disabled interrupts
> generally so it is semi redundant, but it'll help the lock validator at
> least...

Yes, this patch fixes situation.
