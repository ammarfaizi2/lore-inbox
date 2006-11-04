Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753681AbWKDThY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbWKDThY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 14:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbWKDThY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 14:37:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:19990 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1753652AbWKDThX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 14:37:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OBUrP0CrwERqbAqdTFPCKWGpItcUKquuyYfxqlg6E1CAXt0zUq6Lpln4N5fmFccU583qv6/d0RKhFz7ixETO2RVJFMIy+JAd63gT12m6n/4l328OkELavnScn9q1J5gAi8HI9WPwI8L/fHUv8ebtCsw95CAIpQ84XTEH+hmavKo=
Message-ID: <86802c440611041137t74d84e7at3850fc8a10a314cb@mail.gmail.com>
Date: Sat, 4 Nov 2006 11:37:22 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC][PATCH 2/2] htirq: Allow buggy drivers of buggy hardware to write the registers.
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, olson@pathscale.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200611032146.kA3LkUe9031799@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454A7B0F.7060701@pathscale.com>
	 <m1odrpymqc.fsf@ebiederm.dsl.xmission.com>
	 <454B7B70.9060104@pathscale.com>
	 <m1d584xutk.fsf@ebiederm.dsl.xmission.com>
	 <454B880A.1010802@pathscale.com>
	 <m1zmb8wexd.fsf@ebiederm.dsl.xmission.com>
	 <454B8E19.90300@pathscale.com>
	 <m1irhww9f9.fsf_-_@ebiederm.dsl.xmission.com>
	 <m1ejskw9as.fsf_-_@ebiederm.dsl.xmission.com>
	 <200611032146.kA3LkUe9031799@ebiederm.dsl.xmission.com>
X-Google-Sender-Auth: a5a9377907b6a3cd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

why not create one standard update function. and use that us default
for cfg->update

YH
