Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbUAIUTB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbUAIUTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:19:01 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:173 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264322AbUAIURl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:17:41 -0500
Date: Fri, 9 Jan 2004 15:17:40 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][SELINUX] 3/7 Add node controls
In-Reply-To: <200401091953.54296.arekm@pld-linux.org>
Message-ID: <Xine.LNX.4.44.0401091515220.22524-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Arkadiusz Miskiewicz wrote:

> > Like the previous patch, similar functionality was present in earlier
> > SELinux implementations; this is a rework within the constraints of the
> > LSM hooks present in the mainline kernel.
> But only for IPv4 right? What about IPv6 part - is SELinux able to deal with 
> IPv6 at all?

Not at this level yet.  There are socket controls which provide coverage
all protocols, and finer grained controls for IPv4 and Unix.  Duplication
of the IPv4-specific controls for IPv6 is expected to be implemented soon.


- James
-- 
James Morris
<jmorris@redhat.com>


