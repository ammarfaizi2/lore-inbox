Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWCNDm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWCNDm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWCNDm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:42:27 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:39019 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932538AbWCNDm0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:42:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=scD2DFbt2OGvIkKiBMPW/OBNuxSG8MfMExEBjRpkH3oeg24VYyd3PH9aB9hDFZkLXDlSr3153wicua4U/rsBK9ug4rNzX0kM7Fq+PGx3/vfCTBw2+rHaN5fAam/m7RjJaQMALvtUl76Hgg02ZYNLmUldtIXu5E9AREpaK4jOKK0=
Message-ID: <661de9470603131942k768d672eq6009769ec58a4329@mail.gmail.com>
Date: Tue, 14 Mar 2006 09:12:24 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [Patch 1/9] timestamp diff
Cc: nagar@watson.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <1142298764.13256.73.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142296939.5858.6.camel@elinux04.optonline.net>
	 <1142298072.13256.70.camel@mindpipe>
	 <1142298325.5858.40.camel@elinux04.optonline.net>
	 <1142298764.13256.73.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You don't think it's a problem that 2.0000001s - 1.9999999s would return
> garbage rather than 0.0000002?
>
> Lee
>

The caller can use set_normalized_timespec() to fix that.

Warm Regards,
Balbir
