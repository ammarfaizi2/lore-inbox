Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVDAQfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVDAQfC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVDAQe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:34:28 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:957 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262784AbVDAQeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:34:24 -0500
Message-ID: <424D7809.4030908@colorfullife.com>
Date: Fri, 01 Apr 2005 18:34:17 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005, Chen, Kenneth W wrote:
> With that said, here goes our first data point along with some historical data
> we have collected so far.
>
> 2.6.11	-13%
> 2.6.9		- 6%
> 2.6.8		-23%
> 2.6.2		- 1%
> baseline	(rhel3)

Is it possible to generate an instruction level oprofile for one recent kernel?
I have convinced Mark Wong from OSDL to generate a few for postgres DBT-2, but postgres is limited by it's user space buffer manager, thus it wasn't that useful:

http://khack.osdl.org/stp/299167/oprofile/


--
	Manfred

