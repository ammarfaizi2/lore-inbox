Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265263AbUHSLPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUHSLPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUHSLPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:15:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24726 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265263AbUHSLPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:15:35 -0400
Message-ID: <41248BD6.8050007@redhat.com>
Date: Thu, 19 Aug 2004 07:15:34 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: opacki@acn.waw.pl
CC: linux-kernel@vger.kernel.org
Subject: Re: Adding sysctl varaible into kernel.
References: <200408191209.37695.opacki@acn.waw.pl> <200408191217.02930.opacki@acn.waw.pl>
In-Reply-To: <200408191217.02930.opacki@acn.waw.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

authn wrote:
> Hi,
> Does anybody know how to add sysctl variable into kernel ? Maybe there is
> some function or I should change the kernel source?
> 
> Regards,
> apacz
register_sysctl_table is the function you are looking for.

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
