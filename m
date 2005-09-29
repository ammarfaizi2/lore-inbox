Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVI2Kxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVI2Kxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 06:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVI2Kxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 06:53:46 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:12732 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750816AbVI2Kxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 06:53:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=iO3EKjYHnaBnHF9o5PvTL0d3mrEwmsqDHAJ+dwH1V9l24FPXI/5O9OhHJBHjp8eCrcMII6GyjHqtrD6yTQ63S+ugE0eXJNsxosV63dx3NRaih+mOWTxTEDmLaCUXq4vFxktwo+LA1U4XsS83AdD9H1Lt03MaGwvE1sSvKjU7vnI=
Date: Thu, 29 Sep 2005 15:04:42 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.2: USB wedged
Message-ID: <20050929110442.GA4509@mipter.zuzino.mipt.ru>
References: <E1EKJyP-0001lb-00@bigred.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EKJyP-0001lb-00@bigred.inka.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 08:14:37PM +0200, Olaf Titz wrote:
> Sometimes when trying to print big jobs on an HP LJ 1022 it happens
> that all processes accessing USB get stuck in D state.
> I captured the following relevant stack traces, but apparently this does not
> include kernel threads (there was another "khubd" stuck):

I've filed a bug at kernel bugzilla, so yours reports won't be lost.
See http://bugzilla.kernel.org/show_bug.cgi?id=5325

Please, register at http://bugme.osdl.org/createaccount.cgi and add
yourself to CC list.

