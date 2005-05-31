Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVEaK2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVEaK2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVEaK2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:28:52 -0400
Received: from gate.in-addr.de ([212.8.193.158]:31190 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261475AbVEaK2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:28:48 -0400
Date: Tue, 31 May 2005 12:26:24 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Robert Wipfel <rawipfel@novell.com>, davidnicol@gmail.com,
       phillips@redhat.com
Cc: linux-ha@lists.linux-ha.org, linux-cluster@redhat.com,
       linux-fsdevel@vger.kernel.org, dcl_discussion@lists.osdl.org,
       cgl_discussion@lists.osdl.org, linux-kernel@vger.kernel.org,
       ssic-linux-devel@lists.sourceforge.net, clusters_sig@lists.osdl.org
Subject: Re: [Clusters_sig] Re: [ANNOUNCE] Linux Cluster Summit 2005
Message-ID: <20050531102624.GT17565@marowsky-bree.de>
References: <s28eff68.098@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s28eff68.098@sinclair.provo.novell.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-05-21T09:29:01, Robert Wipfel <rawipfel@novell.com> wrote:

> outside looking in, is web services an!  d grid.  Returning to the
> reality of many vendor's enterprise* business, the suitespot for h/a
> clusters still seems to be somewhere around ~8 dual-CPU nodes with
> many customers deploying multiple similar clusters. Nodes are never in
> multiple clusters at once, rather, individual nodes are members of a
> cluster and that cluster might be a member of a cluster of clusters.

A single node must be big enough to support sane load balancing; ie, big
enough to run at least one (or more) "whole" resource entities / jobs.

That is the breaking point after which it is more sensible to deploy
more nodes - with looser coupling - than making a single node / SSI
component larger, because decoupled operation means less complexity for
fault isolation.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

