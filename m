Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWCIRCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWCIRCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWCIRCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:02:00 -0500
Received: from hierophant.serpentine.com ([66.92.13.71]:19616 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1752056AbWCIRB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:01:58 -0500
Subject: Re: filldir[64] oddness
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, davej@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060309044025.GS27946@ftp.linux.org.uk>
References: <20060309042744.GA23148@redhat.com>
	 <20060308.203204.115109492.davem@davemloft.net>
	 <20060309044025.GS27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 09:02:22 -0800
Message-Id: <1141923743.17294.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 04:40 +0000, Al Viro wrote:
> On Wed, Mar 08, 2006 at 08:32:04PM -0800, David S. Miller wrote:
> 
> > I think coverity is being trigger happy in this case :-)
> 
> If that's coverity, I'm very disappointed and more than a little
> suspicious about the quality of their results.

About half of the ~50 reports I've looked at so far in their database
have been false positives.  In most of those cases, it's not obvious how
a checker might have gotten them right instead, though.

	<b

