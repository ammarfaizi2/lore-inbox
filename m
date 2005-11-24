Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVKXReF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVKXReF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVKXReE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:34:04 -0500
Received: from main.gmane.org ([80.91.229.2]:23718 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932222AbVKXReD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:34:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Michael Renner <michael.renner@geizhals.at>
Subject: Re: faulty oom-killer on amd64?
Date: Thu, 24 Nov 2005 17:27:59 +0000 (UTC)
Message-ID: <loom.20051124T182006-575@post.gmane.org>
References: <loom.20051124T013917-518@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.229.14.38 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Renner <michael.renner <at> geizhals.at> writes:

> On the 16 processor machine I get CPU lockups with identical traces which can
> be seen at http://666kb.com/i/10yov42ydfdog.jpg and
> http://666kb.com/i/10yom358azw8w.jpg (this was tested with 2.6.14 and
> 2.6.15-rc2 respectively).

Ok, retried this with burnMMX on the "large" box, apparently the killer works in
some cases. (It killed the offending burnMMX processes after stalling for a
minute or two, but I guess I can't blame the scheduler when it hast to handle
more than 1000 running processes).

Still, the situation isn't favorable with the other workloads which lead to 
lockups.

best regards,
Michael Renner

