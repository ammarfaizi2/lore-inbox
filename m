Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTFUWbk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 18:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTFUWbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 18:31:40 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:27640 "EHLO
	imf22aec.bellsouth.net") by vger.kernel.org with ESMTP
	id S262413AbTFUWbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 18:31:39 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: Kernel facilities for tracking file accesses
Date: Sat, 21 Jun 2003 18:45:41 -0400
User-Agent: KMail/1.5.2
References: <20030621204615.GA32341@peter.cfs> <3EF4DCEF.7080708@yahoo.ca>
In-Reply-To: <3EF4DCEF.7080708@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306211845.41702.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Does any facility exist in the 2.4 and up kernels for logging *every* open, 
read, write, seek, close, etc call?  I'm trying to debug a problem in a 
package I don't have source to, and I'm trying to prove that it's not 
applying a configuration path option to files it's opening.  

	Ideally, I'd like a kernel module I can load that I can apply a regexp or 
limited pattern matchng to, and will log a selected group of operations as 
defined by a bitmask or other configuration option.  I would prefer something 
that monitors the entire system, rather than trying to sandbox this 
particular program (it runs as a daemon).

	Do the kernels have facilties for such tracking?

	--John

