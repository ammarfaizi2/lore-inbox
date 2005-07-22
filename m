Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVGVUEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVGVUEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVGVUEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:04:09 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36523 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262153AbVGVUED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:04:03 -0400
Subject: Re: slow tcp acks on loopback device
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: samba-technical@lists.samba.org
In-Reply-To: <1122062219.29258.12.camel@stevef95.austin.ibm.com>
References: <1122062219.29258.12.camel@stevef95.austin.ibm.com>
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1122062439.29257.16.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Jul 2005 15:00:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 14:56, Steve French wrote:
> I am seeing odd tcp characteristics on the loopback device.

Although probably not related ... I thought it worth mentioning that
ethereal claims bad tcp checksum on the 2nd of each pair of tcp response
frames (the smaller one) when run on the loopback device.   When the mtu
is increased, ethereal reports no tcp checksum error.

