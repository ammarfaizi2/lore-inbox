Return-Path: <linux-kernel-owner+w=401wt.eu-S932478AbXARQmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbXARQmJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 11:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbXARQmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 11:42:09 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:43859 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932478AbXARQmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 11:42:07 -0500
X-YMail-OSG: NHGMAa0VM1kAa4DW_bGWgDwk66yWCaHsgq4FJQ7tTKT3ceHvqkAVv..PnBgVWQWsPIMq7.FBTj72zvkiwoas4YWoJA3yJNBxo8ykQPnTppBXMlREgIJcJhx9.Vb80Co.vc7xMDD29ZPSX2VXqj9RAgi4rNe2TJIG9A--
Date: Thu, 18 Jan 2007 08:42:04 -0800
From: Chris Wedgwood <cw@f00f.org>
To: joachim <joachim.kernel@googlemail.com>
Cc: Andi Kleen <ak@suse.de>, Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Message-ID: <20070118164204.GB27305@tuatara.stupidest.org>
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45AD2D00.2040904@scientia.net> <20070116203143.GA4213@tuatara.stupidest.org> <200701170829.54540.ak@suse.de> <45AF3DEA.1070309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AF3DEA.1070309@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 10:29:14AM +0100, joachim wrote:

> Not only has it only been on Nvidia chipsets but we have only seen
> reports on the Nvidia CK804 SATA controller.

People have reported problems with other controllers.  I have one here
I can test given a day or so.

I don't think it's SATA related, it just happens that it shows up well
there, for networking you would end up with the odd corrupted packet
probably and end up just dropping those so it might not be noticeable.

