Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTH2X1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 19:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTH2X1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 19:27:43 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:692 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S262005AbTH2X1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 19:27:40 -0400
Message-ID: <3F4FDFEC.9040804@rackable.com>
Date: Fri, 29 Aug 2003 16:21:16 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: michael_pruznick@mvista.com
CC: linux-kernel@vger.kernel.org
Subject: Re: root=nfs no longer works in 2.4.22
References: <3F4FDD44.4151E86C@mvista.com>
In-Reply-To: <3F4FDD44.4151E86C@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Aug 2003 23:27:39.0972 (UTC) FILETIME=[23603840:01C36E85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Pruznick wrote:

>Was root=nfs removed on purpose or is it an unexpected
>side effect of the "ROOT NFS fixes" patch from late
>July 2003?
>
>I understand this patch from the point of wanting to
>eliminate nfs attempts when nfs is not requested.  That
>is clearly a reasonable thing to do.  However, "root=nfs"
>is a nfs request that has been accepted in the past, I've
>been told, because nfs isn't a real device (but maybe it
>was accepted as bug and this patch fixed it).
>
>  
>
  
   So something like this doesn't work?
root=/dev/nfs ip=::::::dhcp nfsroot=10.10.1.1:/nfsroot

  I know that this was work in rc2.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


