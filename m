Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbUKDGsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbUKDGsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUKDGsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:48:33 -0500
Received: from [211.58.254.17] ([211.58.254.17]:23198 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262105AbUKDGrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:47:09 -0500
Date: Thu, 4 Nov 2004 15:47:07 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 6/15] driver-model: ':' added to default param_array delimiters
Message-ID: <20041104064706.GF24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_06_param_array_delim_colon.patch

 This is the 6th patch of 15 patches for devparam.

 This adds ':' to the delimeters for param_array().  ':' is used as
the nested array delimeter in devparam.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/moduleparam.h
===================================================================
--- linux-export.orig/include/linux/moduleparam.h	2004-11-04 14:25:58.000000000 +0900
+++ linux-export/include/linux/moduleparam.h	2004-11-04 14:25:58.000000000 +0900
@@ -199,7 +199,7 @@ static inline int param_array(const char
 {
 	return param_array_delims(name, val, min_val, max_val,
 				  min_elems, max_elems, elem, elemsize,
-				  set, num, ",");
+				  set, num, ",:");
 }
 
 
