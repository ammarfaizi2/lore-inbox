Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVCITmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVCITmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVCITmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:42:22 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:48365 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261254AbVCITl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:41:59 -0500
Message-ID: <422F516E.7040308@nortel.com>
Date: Wed, 09 Mar 2005 13:41:34 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin M. Forbes" <jmforbes@linuxtx.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.Stable and EXTRAVERSION
References: <20050309185331.GB19306@linuxtx.org>
In-Reply-To: <20050309185331.GB19306@linuxtx.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin M. Forbes wrote:
> With the new stable series kernels, the .x versioning is being added to
> EXTRAVERSION.  This has traditionally been a space for local modification.
> I know several distributions are using EXTRAVERSION for build numbers,
> platform and assorted other information to differentiate their kernel
> releases.
> I would propose that the new stable series kernels move the .x version
> information somewhere more official.  I certainly do not mind throwing
> together a patch to support DOTVERSION or what ever people want to call it.
> Is anyone opposed to such a change?

Distros could conceivably use CONFIG_LOCALVERSION, although it might be 
cleaner to add another version level.

Chris
