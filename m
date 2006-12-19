Return-Path: <linux-kernel-owner+w=401wt.eu-S932773AbWLSKu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbWLSKu0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbWLSKuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:50:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:4960 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932773AbWLSKuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:50:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=R2xsSNIQ7uiRTFU7DDWPD/ifoH/SU5nWvK8gntETOzHJDoULCWpTJj35jYqb8CM7Ru29N7TPbyXfrg11h2rBIJ9v4Y/ITw+JYKYkI29Ku61BlvZSQ201x4nNWvcx/ish0Q05c7Y37maWqvV0g7ULFegwMA8KWVNRVngcEgOfxnI=
Message-ID: <4587C3E9.7070504@gmail.com>
Date: Tue, 19 Dec 2006 19:50:17 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Erik@echohome.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Odd system lock up
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAICP4fRQtKBOo0M5d3WXPNMBAAAAAA==@EchoHome.org>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAICP4fRQtKBOo0M5d3WXPNMBAAAAAA==@EchoHome.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Ohrnberger wrote:
> OK, got the 2.6.19 kernel installed and running OK, full libata wrapping of
> existing IDE controllers and hard disks.
> 
> I'm experiencing some odd, random periodic system lockups without any sort
> of debugging information being captured in the system message log.  Perhaps
> it's a hard disk that's causing the trouble?
> 
> Is there a way to capture which drive might be causing the issue in the
> message log?

Care to post /var/log/boot.msg or the result of 'dmesg' after boot?

-- 
tejun
