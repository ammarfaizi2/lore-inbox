Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265101AbUGIRFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbUGIRFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 13:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265104AbUGIRFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 13:05:51 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:8847 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265101AbUGIRFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 13:05:48 -0400
Date: Fri, 9 Jul 2004 18:04:54 +0100
From: Dave Jones <davej@redhat.com>
To: jmerkey@comcast.net
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Message-ID: <20040709170454.GB3891@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, jmerkey@comcast.net,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <070920041636.14668.40EEC97D000D82330000394C2200748184970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <070920041636.14668.40EEC97D000D82330000394C2200748184970A059D0A0306@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 04:36:14PM +0000, jmerkey@comcast.net wrote:

 > > Do you create a subdirectory for every user?  
 > Yes.  Snort creates a subdirectory for each IP address identified as generation an attack
 > or alert.  This number can get very large, BTW.

The last time I looked at snort it created a tcpdump capture file of the
days activity.  I remember seeing the behaviour you describe in an earlier
release, so either you have an old version (which you should probably
update given snort's sketchy security hole history), or theres a configuration
option that you might be able to fiddle with to get it to work in capture-file
mode.

Either way, it's got to be easier than hacking ext3 code 8)

		Dave

