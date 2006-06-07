Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWFGSzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWFGSzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWFGSzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:55:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:3567 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932353AbWFGSzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:55:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=eeQherdLcxEKQ6u1QXtPEhg2mdHh3HnButlX4yM9uRBSniXg/rrWrTz3JnyFvEqjDxrViaZfzfrHOMS0iKqsw3wX80Do6M2odsZG1dT+BgRiiBfy+AikJHRueYkwGmVvwmRU4iTWMONo33KP1INbIp+GMR7oLpqZKkxkdrJ0c9w=
Date: Wed, 7 Jun 2006 20:53:16 +0200
From: Diego Calleja <diegocg@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, netdev@vger.kernel.org, linux-xfs@oss.sgi.com,
       ecki@lina.inka.de, lkml@rtr.ca
Subject: Updated sysctl documentation take #2
Message-Id: <20060607205316.bbb3c379.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since people didn't like the "many small files" approach, I've moved
it to directories containing index.txt files:

Documentation/sysctl/vm/index.txt
Documentation/sysctl/net/core/index.txt
Documentation/sysctl/net/unix/index.txt
Documentation/sysctl/net/ipv4/index.txt
Documentation/sysctl/net/ipv4/conf/index.txt
Documentation/sysctl/net/ipv4/route/index.txt
Documentation/sysctl/net/ipv4/neigh/index.txt

and so on.

As previously, this moves all sysctl documentation (including
XFS and network) to Documentation/sysctl/*. The patch is
against linus tree and weights more than 200K in size
and is place at: http://www.terra.es/personal/diegocg/sysctl-docs

Comments?
