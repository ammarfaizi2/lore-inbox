Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132922AbRDYWqc>; Wed, 25 Apr 2001 18:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132958AbRDYWqW>; Wed, 25 Apr 2001 18:46:22 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:57327 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S132922AbRDYWqR>; Wed, 25 Apr 2001 18:46:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
Date: Thu, 26 Apr 2001 00:46:39 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200104252116.QAA46520@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200104252116.QAA46520@tomcat.admin.navo.hpc.mil>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01042600463900.01143@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 April 2001 23:16, you wrote:
> Not necessarily. If the "extended data" is put following the current data
> (since the data is currently record oriented) just making the output
> format longer will not/should not casue problems in reading the data.
> Alternatively, you can always put one value per record:
> 	tag:value
> 	tag2:value2...

Both solutions only work for simple data, they dont help for more complex 
things like adding a variable-sized list of structures. Actually the first 
devreg version used something like your second proposal and I gave it up 
because it wasnt flexible enough to add USB configuration data. 

bye...

