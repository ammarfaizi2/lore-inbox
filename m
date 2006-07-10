Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWGJOOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWGJOOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWGJOOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:14:36 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:24971 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030390AbWGJOOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:14:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bi1YaezPR7A8QJMtH+ksc2WnOdbIi8ls3qebGPyL59H5u0ceQPM2vZi0prDt5LFj2f6sLvZ+jMtu0kiEuorraWylXUQypKejediwqLSAN0ac8e+JAgu8ondBW/hoKeSXaGnk5OqqIk1Ik4SdVaeBXhsYX0nxnyptvM7i6IE3WQc=
Message-ID: <44B26105.9080105@gmail.com>
Date: Mon, 10 Jul 2006 23:15:33 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata-tj-stable against v2.6.17.4 available
References: <20060708123242.GE2592@htj.dyndns.org>
In-Reply-To: <20060708123242.GE2592@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated version available.

* Link resume handling in the previous version was broken causing libata 
to ignore hotplug event after a link has been hot-unplugged.  Fixed.

* A few other hotplug related problems are fixed.

I expect this version to have well-behaving PMP and hotplug support. If 
anything seems weird, please report.

More info can be found at the following URL.

http://home-tj.org/wiki/index.php/Libata-tj-stable

Updated patches against v2.6.17.4 are at the following URL.

http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060710.tar.bz2 


Thanks.

-- 
tejun
