Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269728AbUINUBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269728AbUINUBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269758AbUINUB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:01:29 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:50604 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269750AbUINUAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:00:42 -0400
Message-ID: <41474DE4.3070208@nortelnetworks.com>
Date: Tue, 14 Sep 2004 14:00:36 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Giacomo A. Catenazzi" <cate@debian.org>, linux-kernel@vger.kernel.org,
       Tigran Aivazian <tigran@veritas.com>
Subject: Re: udev is too slow creating devices
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com>
In-Reply-To: <20040914195221.GA21691@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Sep 14, 2004 at 01:40:22PM -0600, Chris Friesen wrote:

>>One workaround would be to have microcode_ctl use dnotify to get woken up 
>>whenever /dev changes.
> 
> 
> Ick, no.  Use the /etc/dev.d/ notify method I described.  That is what
> it is there for.

Right.  Sorry, it's been a while since I looked at udev.

Chris
