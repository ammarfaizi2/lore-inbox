Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVHKXCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVHKXCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 19:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVHKXCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 19:02:32 -0400
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:58590 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932468AbVHKXCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 19:02:31 -0400
Date: Thu, 11 Aug 2005 19:02:28 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: serue@us.ibm.com
cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Stacker - single-use static slots
In-Reply-To: <20050811212209.GB28004@serge.austin.ibm.com>
Message-ID: <Pine.LNX.4.63.0508111852420.30662@excalibur.intercode>
References: <20050727181732.GA22483@serge.austin.ibm.com>
 <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com>
 <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com>
 <20050803164516.GB13691@serge.austin.ibm.com>
 <Lynx.SEL.4.62.0508051154150.8981@thoron.boston.redhat.com>
 <20050810144516.GA5796@serge.austin.ibm.com> <Pine.LNX.4.63.0508110331250.27749@excalibur.intercode>
 <20050811212209.GB28004@serge.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, serue@us.ibm.com wrote:

> I guess I should do some profiling runs - I'm surprised there would be
> this much of a hit with the static slots.

Yes.  It could be some cache effect, where the exact placement of the 
SELinux pointer might be critical, and also vary depending on the hook and 
subclass of SELinux security struct.

- James
-- 
James Morris
<jmorris@namei.org>
