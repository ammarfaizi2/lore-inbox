Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWANOpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWANOpc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWANOpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:45:32 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:2881 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750989AbWANOpc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:45:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CFyc6X5wA8mEWuQzNNu+Jvnn/kOYTJTl2yKkt+e+8rPhB2HlKuCy8vaIUK4agHjqGbxVBXz2wnB46UKUW5ZL2XszQW0vcqjSBNL+nUxX5i3apHySAmfdudPVLEK3vwwlxtsNaQmelwff+/qdJfphIWvPTvB25t3LHAnk/VoalPA=
Message-ID: <35fb2e590601140645x26e3c52bl994ecf20aec57c65@mail.gmail.com>
Date: Sat, 14 Jan 2006 14:45:31 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Ratheesh k <ratheesh.ksz@hotmail.com>
Subject: Re: change eth0 to sn0 ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY17-F29079CAE51CD9B122B8FC997190@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <BAY17-F29079CAE51CD9B122B8FC997190@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/06, Ratheesh k <ratheesh.ksz@hotmail.com> wrote:

> what i want is , i want to  use the hw addreess of eth0 , irq of eth0 to sn0

> $ ifconfig  sno 172.16.8.1 mtu 1500 irq 193 hw ether 00:11:2f:77:fd:c2

You don't want to set the IRQ of sn0 equal to that of eth0 :-)

Jon.
