Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUCVRA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbUCVRA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:00:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22743 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262119AbUCVRAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:00:23 -0500
Message-ID: <405F1B99.3050707@pobox.com>
Date: Mon, 22 Mar 2004 12:00:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clay Haapala <chaapala@cisco.com>
CC: James Morris <jmorris@redhat.com>, Jouni Malinen <jkmaline@cc.hut.fi>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       Matt_Domsch@dell.com
Subject: Re: [PATCH] lib/libcrc32c implementation
References: <Xine.LNX.4.44.0403211006190.16503-100000@thoron.boston.redhat.com> <yqujptb4ltc9.fsf@chaapala-lnx2.cisco.com>
In-Reply-To: <yqujptb4ltc9.fsf@chaapala-lnx2.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clay Haapala wrote:
> This patch agains 2.6.4 kernel code implements the CRC32C algorithm.
> The routines are based on the same design as the existing CRC32 code.
> Licensing is intended to be identical (GPL).
> 
> The immediate customer of this code is the wrapper code in
> crypto/crc32c, available in another patch.


Why not call it 'crc32c' like its cousin crc32, rather than the 
less-similar 'libcrc32c'?  Violates the Principle of Least Surprise ;-)

	Jeff



