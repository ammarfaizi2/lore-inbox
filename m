Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVCHK20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVCHK20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVCHK20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:28:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:63161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261965AbVCHK2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:28:21 -0500
Date: Tue, 8 Mar 2005 02:27:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: sebastien.dugue@bull.net, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com, daniel@osdl.org
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-Id: <20050308022704.6dc9da34.akpm@osdl.org>
In-Reply-To: <20050308102700.GA4207@in.ibm.com>
References: <1110189607.11938.14.camel@frecb000686>
	<20050307223917.1e800784.akpm@osdl.org>
	<20050308090946.GA4100@in.ibm.com>
	<20050308011814.706c094e.akpm@osdl.org>
	<20050308094159.GA4144@in.ibm.com>
	<20050308014141.08a546a9.akpm@osdl.org>
	<20050308102700.GA4207@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> But, I'm wondering if this solution just covers up the real reason
>  for the single thread problem ? We shouldn't even be issuing IOs
>  beyond i_size into the user-space buffer !

That's true.
