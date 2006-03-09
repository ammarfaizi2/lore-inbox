Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWCIEk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWCIEk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWCIEk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:40:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:17576 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932342AbWCIEk2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:40:28 -0500
Date: Thu, 9 Mar 2006 04:40:25 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: filldir[64] oddness
Message-ID: <20060309044025.GS27946@ftp.linux.org.uk>
References: <20060309042744.GA23148@redhat.com> <20060308.203204.115109492.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308.203204.115109492.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 08:32:04PM -0800, David S. Miller wrote:

> I think coverity is being trigger happy in this case :-)

If that's coverity, I'm very disappointed and more than a little
suspicious about the quality of their results.  This sort of
misparsing is easily made by human reader, but anything doing
type analysis must handle that case without any problems.
