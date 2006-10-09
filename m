Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWJIDG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWJIDG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 23:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWJIDGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 23:06:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:47108 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932203AbWJIDGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 23:06:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qAhR5xjePO8RfVzte3CPbfkSDzqKPXXoQFhZhpGL7b/iFyHmBRMgs8/Sqdhmz3w2iUoO3nmC+yRIYSNkVsUjfWQjd8CfzRmB0n1Yu6QD0ko21hNDz4K0Krta0BYo+6lLxAFYqsSqyTA/geaKnpJbuQJ4OGul6D96V/oJ4PkID+Q=
Message-ID: <4529BCC4.8060906@gmail.com>
Date: Mon, 09 Oct 2006 12:06:44 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Joe Jin <lkmaillist@gmail.com>
CC: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>	 <451E7BD2.7020002@gmail.com> <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>
In-Reply-To: <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Jin wrote:
> it still  occured after apply the patch :(

SRST failure would have still occurred but 30sec timeout should have 
gone.  Can you post full dmesg?

Also, please test the patch in the following mail.  You can use either 
git or download the full kernel tarball to get the modified kernel.

http://article.gmane.org/gmane.linux.ide/13284

Thanks.

-- 
tejun
