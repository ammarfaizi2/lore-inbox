Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWCHUZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWCHUZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWCHUZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:25:13 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:63174 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932217AbWCHUZM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:25:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oQHC0IeraTMbhB/FLPX3gywVy3kgyYa7BcS03xp9GsWMwG25/VgvbgLFuCr+XyOeK4bPaW0yZAO8KOd1nvMJXuCQTaGplTO9RASFgS0fAFqSOyigzOz/WViYPoBW5H9RTeNOoNFjrv4zA4Mw+z6FwwHLt2jxzpeUmxMArFl9d6A=
Message-ID: <305c16960603081225m68c26ff7wd3b73621cfb81d9a@mail.gmail.com>
Date: Wed, 8 Mar 2006 17:25:11 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: usbkbd not reporting unknown keys
In-Reply-To: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just discovered it needs usb debugging to be set. But isnt
inconsistent the fact that the atkbd driver does this differently from
the usbkbd driver? If its a good idea to print those messages by
default or one, why its not for the other?
